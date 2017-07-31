package com.realsport.model.dao.daoException;

/**
 * Created by Igor Ryabtsev on 28.12.2016.
 * Класс исключения для передачи информации пользователю об ошибке
 */
public class DataBaseException extends Exception {
    public  static final String ERORR_MESSAGE = "Сообщение пользователю: Произошла ошибка при запросе к базе данных";

    public DataBaseException() {
        super();
    }

    public DataBaseException(String erorrMessage) {

        super(erorrMessage);
    }

    public String message() {
        return "Сообщение пользователю: Произошла ошибка при запросе к базе данных";
    }
}
