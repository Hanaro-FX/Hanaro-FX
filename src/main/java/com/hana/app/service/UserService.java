package com.hana.app.service;

import com.hana.app.data.dto.UserDTO;
import com.hana.app.frame.BaseService;
import com.hana.app.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class UserService implements BaseService<Integer, UserDTO> {

    final UserRepository userRepository;

    public Integer getUserId(UserDTO userInfo) throws Exception {
        UserDTO result = userRepository.selectByNameAndEmail(userInfo);
        if(result == null){
            return insert(userInfo);
        }
        return result.getId();
    }

    @Override
    public int insert(UserDTO userDTO) throws Exception {
        return userRepository.insert(userDTO);
    }

    @Override
    public int delete(Integer integer) throws Exception {
        return 0;
    }

    @Override
    public int update(UserDTO userDTO) throws Exception {
        return 0;
    }

    @Override
    public UserDTO selectOne(Integer integer) throws Exception {
        return null;
    }

    @Override
    public List<UserDTO> selectAll() throws Exception {
        return null;
    }
}
