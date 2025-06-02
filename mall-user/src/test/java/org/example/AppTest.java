package org.example;

import junit.framework.Test;
import junit.framework.TestCase;
import junit.framework.TestSuite;

/**
 * Unit test for simple App.
 */
public class AppTest
        extends TestCase {
    /**
     * Create the test case
     *
     * @param testName name of the test case
     */
    public AppTest(String testName) {
        super(testName);
    }

    /**
     * @return the suite of tests being tested
     */
    public static Test suite() {
        return new TestSuite(AppTest.class);
    }

    /**
     * Rigourous Test :-)
     */
//    public void testApp()
//    {
//        assertTrue( true );
//    }
//    @Autowired
//    private MemberController controller;
//    @org.junit.jupiter.api.Test
//    public void test01(){
//        ResponseResult login = controller.login("111", "111");
//        System.out.println(login);
//    }
//    @org.junit.jupiter.api.Test
//    public void test02(){
//        Member member = new Member();
//        member.setUsername("member10086");
//        member.setPassword("11111111");
//        ResponseResult login = controller.register(member);
//        System.out.println(login);
//    }
}
