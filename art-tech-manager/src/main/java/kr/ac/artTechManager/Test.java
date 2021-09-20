package kr.ac.artTechManager;

import java.io.File;
import java.io.IOException;

import org.rosuda.REngine.Rserve.RserveException;

import kr.ac.artTechManager.util.LogFileReader;

public class Test {

	public static void main(String[] args) {
		try {
			new LogFileReader().getLoginTopMember();
		} catch (RserveException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
