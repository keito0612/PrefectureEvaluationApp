//
//  FirebaseError.swift
//  PrefectureEvaluationApp
//
//  Created by 磯部馨仁 on 2023/08/12.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

public enum AuthError: Error {
    // ネットワークエラー
    case networkError
    // パスワードが条件より脆弱であることを示します。
    case weakPassword
    // ユーザーが間違ったパスワードでログインしようとしたことを示します。
    case wrongPassword
    // ユーザーのアカウントが無効になっていることを示します。
    case userNotFound
    // メールアドレスの形式が正しくないことを示します。
    case invalidEmail
    // 既に登録されているメールアドレス
    case emailAlreadyInUse
    // 不明なエラー
    case unknown
    
    //エラーによって表示する文字を定義
    var title: String {
        switch self {
        case .networkError:
            return "通信エラーです。"
        case .weakPassword:
            return "パスワードは８文字以上でお願いします。"
        case .wrongPassword:
            return "メールアドレス、もしくはパスワードが違います。"
        case .userNotFound:
            return "アカウントがありません。"
        case .invalidEmail:
            return "正しくないメールアドレスの形式です。"
        case .emailAlreadyInUse:
            return "既に登録されているメールアドレスです。"
        case .unknown:
            return "エラーが起きました。"
        }
    }
    var message: String
    {
        switch self {
        case .networkError:
            return "電波が良い所でもう一度お願いします。"
        case .weakPassword:
            return ""
        case .wrongPassword:
            return ""
        case .userNotFound:
            return ""
        case .invalidEmail:
            return "正しいメールアドレスの形式で入力してください。"
        case .emailAlreadyInUse:
            return "別のアカウントでお試しください"
        case .unknown:
            return "何かしらのエラーが発生しました。"
        }
    }
}


public enum FireStoreError: Error {
    
    case cancelled
    
    case unknown
    
    case invalidArgument
    
    case notFound
    
    case alreadyExists
    
    case permissionDenied
    
    case aborted
    
    case outOfRange
    
    case unimplemented
    
    case unavailable
    
    case unauthenticated
    
    case `internal`
    //エラーによって表示する文字を定義
    var title: String {
        switch self {
        case .cancelled:
            return "操作キャンセル"
        case .unknown:
            return "エラーが発生しました。"
        case .invalidArgument:
            return "無効な引数"
        case .notFound:
            return "ドキュメントが見つかりません"
        case .alreadyExists:
            return "作成しようとしているドキュメントは既に存在します"
        case .permissionDenied:
            return "この操作を実行する権限がありません"
        case .aborted:
            return "操作が中止されました"
        case .outOfRange:
            return "無効な範囲"
        case .unimplemented:
            return "この操作は実装されていないか、まだサポートされていません。"
        case .unavailable:
            return "現在、サービスは利用できません。再試行してください"
        case .internal:
            return "内部エラー"
        case .unauthenticated:
            return "認識されていないユーザを使っています。"
        }
    }
    var message: String {
        switch self {
        case .cancelled:
            return "操作がキョンセルされました。"
        case .unknown:
            return "もう一度お願いします。"
        case .invalidArgument:
            return "無効な引数が使われています。"
        case .notFound:
            return "ドキュメントを作成してください。"
        case .alreadyExists:
            return "別のドキュメントを作成してください"
        case .permissionDenied:
            return "Firebaseのセキュリティーコードを確認てください。"
        case .aborted:
            return "何らかのエラーにより処理が中断されました。"
        case .outOfRange:
            return "有効な範囲で実行してください。"
        case .unimplemented:
            return ""
        case .unavailable:
            return ""
        case .internal:
            return ""
        case .unauthenticated:
            return "認識してくからお使いください。"
        }
    }
}


class FirebaseErrorHandler{
    
    static  func authErrorToString(error: AuthErrorCode.Code) -> String {
        switch error {
        case .networkError:
            return AuthError.networkError.title
        case .weakPassword:
            return AuthError.weakPassword.title
        case .wrongPassword:
            return AuthError.wrongPassword.title
        case .userNotFound:
            return AuthError.userNotFound.title
        case .invalidEmail:
            return  AuthError.invalidEmail.title
        case .emailAlreadyInUse:
            return  AuthError.emailAlreadyInUse.title
        default:
            return AuthError.unknown.title
        }
    }
    
    static  func authErrorMessageToString(error: AuthErrorCode.Code) -> String {
        switch error {
        case .networkError:
            return AuthError.networkError.message
        case .weakPassword:
            return AuthError.weakPassword.message
        case .wrongPassword:
            return AuthError.wrongPassword.message
        case .userNotFound:
            return AuthError.userNotFound.message
        case .invalidEmail:
            return  AuthError.invalidEmail.message
        case .emailAlreadyInUse:
            return  AuthError.emailAlreadyInUse.message
        default:
            return AuthError.unknown.message
        }
    }
    
    
    
    static func FireStoreErrorToString(error: FirestoreErrorCode.Code)  -> String {
        switch error {
        case .cancelled:
            return FireStoreError.cancelled.title
        case .unknown:
            return FireStoreError.unknown.title
        case .invalidArgument:
            return FireStoreError.invalidArgument.title
        case .notFound:
            return FireStoreError.notFound.title
        case .alreadyExists:
            return FireStoreError.alreadyExists.title
        case .permissionDenied:
            return FireStoreError.permissionDenied.title
        case .aborted:
            return FireStoreError.aborted.title
        case .outOfRange:
            return FireStoreError.outOfRange.title
        case .unimplemented:
            return FireStoreError.unimplemented.title
        case .internal:
            return  FireStoreError.internal.title
        case .unavailable:
            return FireStoreError.unavailable.title
        case .unauthenticated:
            return FireStoreError.unauthenticated.title
        default:
            return "データを取得する事ができませんでした。もう一度お願いします。"
            
        }
    }
    
    
    static func FireStoreErrorMessageToString(error: FirestoreErrorCode.Code)  -> String {
        switch error {
        case .cancelled:
            return FireStoreError.cancelled.message
        case .unknown:
            return FireStoreError.unknown.message
        case .invalidArgument:
            return FireStoreError.invalidArgument.message
        case .notFound:
            return FireStoreError.notFound.message
        case .alreadyExists:
            return FireStoreError.alreadyExists.message
        case .permissionDenied:
            return FireStoreError.permissionDenied.message
        case .aborted:
            return FireStoreError.aborted.message
        case .outOfRange:
            return FireStoreError.outOfRange.message
        case .unimplemented:
            return FireStoreError.unimplemented.message
        case .internal:
            return  FireStoreError.internal.message
        case .unavailable:
            return FireStoreError.unavailable.message
        case .unauthenticated:
            return FireStoreError.unauthenticated.message
        default:
            return ""
            
        }
    }

    
    
}
