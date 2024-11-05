
            set(SRC_DIR $ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/rocprim)
            set(LINK_DIR $ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/rocprim/lib/cmake)
            set(INCLUDED_FILES "")
            if(NOT EXISTS ${LINK_DIR})
                file(MAKE_DIRECTORY ${LINK_DIR})
            endif()
            file(GLOB TARGET_FILES
                LIST_DIRECTORIES false
                RELATIVE ${SRC_DIR}
                ${SRC_DIR}/rocprim-targets*.cmake
            )
            foreach(filename rocprim-config.cmake rocprim-config-version.cmake ${TARGET_FILES} ${INCLUDED_FILES})
                file(RELATIVE_PATH LINK_PATH ${LINK_DIR} ${SRC_DIR}/${filename})
                if(NOT EXISTS ${LINK_DIR}/${filename})
                    execute_process(COMMAND ${CMAKE_COMMAND} -E create_symlink
                        ${LINK_PATH}
                        ${LINK_DIR}/${filename}
                    )
                endif()
            endforeach()
            