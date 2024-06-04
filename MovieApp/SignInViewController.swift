//
//  SignInViewController.swift
//  MovieApp
//
//  Created by 강한결 on 6/4/24.
//

import UIKit
import SnapKit

class SignInViewController: UIViewController {
    
    let id = "SignInViewController"
    let placeholders = [" 이메일 주소", " 비밀번호", " 닉네임", " 위치", " 추천코드"]
    
    let titleImageView = UIImageView()
    let textFieldStackView = UIStackView()
    let signInButton = UIButton()
    let additionalLabel = UILabel()
    let switchView = UISwitch()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureView()
        configureLayout()
        configureUI()

    }
    
    func configureView() {
        view.addSubview(titleImageView)
        view.addSubview(textFieldStackView)
        generateTextFields().forEach {
            textFieldStackView.addArrangedSubview($0)
        }
        view.addSubview(signInButton)
        view.addSubview(additionalLabel)
        view.addSubview(switchView)
    }
    
    func configureLayout() {
        titleImageView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(80)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            make.height.equalTo(80)
        }
        
        textFieldStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(80)
            make.top.equalTo(titleImageView.snp.bottom).offset(24)
            make.height.equalTo(200)
        }
        
        signInButton.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(80)
            make.top.equalTo(textFieldStackView.snp.bottom).offset(24)
            make.height.equalTo(40)
        }
        additionalLabel.snp.makeConstraints { make in
            make.top.equalTo(signInButton.snp.bottom).offset(24)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(80)
            make.height.equalTo(40)
        }
        switchView.snp.makeConstraints { make in
            make.top.equalTo(signInButton.snp.bottom).offset(24)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(80)
            make.height.equalTo(40)
        }

    }
    
    func configureUI() {
        titleImageView.backgroundColor = .black
        
        textFieldStackView.axis = .vertical
        textFieldStackView.spacing = 8
        textFieldStackView.distribution = .fillEqually
        textFieldStackView.alignment = .fill
        textFieldStackView.backgroundColor = .clear
        
        signInButton.layer.cornerRadius = 8
        signInButton.setTitle("회원가입", for: .normal)
        signInButton.titleLabel?.font = .systemFont(ofSize: 13)
        signInButton.backgroundColor = .lightGray
        
        additionalLabel.text = "추가 정보 입력하기"
        additionalLabel.font = .systemFont(ofSize: 13)
        additionalLabel.textColor = .black
        
        switchView.onTintColor = .red
    }

    func generateTextFields() -> [UITextField] {
        return placeholders.map {
            let field = UITextField()
            
            field.placeholder = $0
            field.backgroundColor = .blue
            field.font = .systemFont(ofSize: 12)
            field.layer.cornerRadius = 4
            
            return field
        }
    }
    
}
