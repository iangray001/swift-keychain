
import Cocoa
import Security

let kSecClassValue = NSString(format: kSecClass)
let kSecValueDataValue = NSString(format: kSecValueData)
let kSecMatchLimitValue = NSString(format: kSecMatchLimit)
let kSecReturnDataValue = NSString(format: kSecReturnData)
let kSecReturnRefValue = NSString(format: kSecReturnRef)
let kSecMatchLimitAllValue = NSString(format: kSecMatchLimitAll)
let kSecReturnAttributesValue = NSString(format: kSecReturnAttributes)

let keychainQuery: NSMutableDictionary = NSMutableDictionary(
	objects: [kSecClassCertificate, kCFBooleanTrue, kCFBooleanTrue, kCFBooleanTrue, kSecMatchLimitAllValue],
	forKeys: [kSecClassValue, kSecReturnAttributesValue, kSecReturnRefValue, kSecReturnDataValue, kSecMatchLimitValue])

var dataTypeRef : AnyObject?
let rv = SecItemCopyMatching(keychainQuery, &dataTypeRef)
if rv != errSecSuccess {
	print(SecCopyErrorMessageString(rv, nil))
}

var data : NSArray?
data = dataTypeRef as? NSArray
for element in data! {
	let dict : NSDictionary = element as! NSDictionary
	let cert : SecCertificateRef = dict.objectForKey(kSecValueRef) as! SecCertificateRef
	let summary = SecCertificateCopySubjectSummary(cert);
	
	print(summary)
}
