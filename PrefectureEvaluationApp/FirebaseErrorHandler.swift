//
//  FirebaseError.swift
//  PrefectureEvaluationApp
//
//  Created by 磯部馨仁 on 2023/08/12.
//

import Foundation
import FirebaseFirestore

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
            return "パスワードが脆弱です。"
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
}


class FirebaseErrorHandler{
    
    static  func AuthErrorToString(error: AuthError) -> String {
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
        case .unknown:
            return AuthError.unknown.title
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
}
