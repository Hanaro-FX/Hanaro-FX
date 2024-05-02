package com.hana.app.repository;

import com.hana.app.data.dto.UserDTO;
import com.hana.app.frame.BaseRepository;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface UserRepository extends BaseRepository<Integer, UserDTO> {
    UserDTO selectByNameAndEmail(UserDTO userInfo);
}
