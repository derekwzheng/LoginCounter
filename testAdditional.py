"""
Additional functional tests
"""

import unittest
import os
import testLib
        
class TestLoginUser(testLib.RestTestCase):
    """Test user login"""
    def assertResponse(self, respData, count = 1, errCode = testLib.RestTestCase.SUCCESS):
        """
        Check that the response data dictionary matches the expected values
        """
        expected = { 'errCode' : errCode }
        if count is not None:
            expected['count']  = count
        self.assertDictEqual(expected, respData)

    def testLogin1(self):
        respData = self.makeRequest("/users/add", method="POST", data = { 'user' : 'user1', 'password' : 'password'} )
        self.assertResponse(respData, count = 1)
        respData = self.makeRequest("/users/login", method="POST", data = {'user' : 'user1', 'password' : 'password'} )
        self.assertResponse(respData, count = 2)
   	
class TestLoginError(testLib.RestTestCase):
    """Test login with a wrong username or password"""
    def assertResponse(self, respData, errCode = testLib.RestTestCase.ERR_BAD_CREDENTIALS):
        expected = { 'errCode' : errCode }
        self.assertDictEqual(expected, respData)

    def testLogin(self):
        respData = self.makeRequest("/users/add", method="POST", data = {'user' : 'user1', 'password' : 'passw'} )
        respData = self.makeRequest("/users/login", method="POST", data = {'user' : 'user12', 'password' : 'passw'} )
        self.assertResponse(respData)

class TestAddExistingUser(testLib.RestTestCase):
    """Test adding an existing user"""
    def assertResponse(self, respData, errCode = testLib.RestTestCase.ERR_USER_EXISTS):
        expected = { 'errCode' : errCode }
        self.assertDictEqual(expected, respData)

    def testLogin(self):
        respData = self.makeRequest("/users/add", method="POST", data = {'user' : 'user1', 'password' : 'passw'} )
        respData = self.makeRequest("/users/add", method="POST", data = {'user' : 'user1', 'password' : 'password'} )
        self.assertResponse(respData)

class TestUsenameError(testLib.RestTestCase):
    """Test login with a wrong username"""
    def assertResponse(self, respData, errCode = testLib.RestTestCase.ERR_BAD_USERNAME):
        expected = { 'errCode' : errCode }
        self.assertDictEqual(expected, respData)

    def testLogin(self):
        respData = self.makeRequest("/users/add", method="POST", data = {'user' : 'All the sonnets are provided here, with descriptive commentary attached to each one, giving explanations of difficult and unfamiliar words and phrases, and with a full analysis of any special problems of interpretation which arise. Sonnets by other Elizabethan poets are also included, Spenser, Sidney, Drayton and a few other minor authors. The poems of Sir Thomas Wyatt are also given, with both old and modern spelling versions, and with brief notes provided. Check the menu on the left for full details of what is available.', 'password' : 'passw'} )
        self.assertResponse(respData)

class TestPasswordError(testLib.RestTestCase):
    """Test login with a wrong password"""
    def assertResponse(self, respData, errCode = testLib.RestTestCase.ERR_BAD_PASSWORD):
        expected = { 'errCode' : errCode }
        self.assertDictEqual(expected, respData)

    def testLogin(self):
        respData = self.makeRequest("/users/add", method="POST", data = {'user' : 'Shakespeare', 'password' : 'All the sonnets are provided here, with descriptive commentary attached to each one, giving explanations of difficult and unfamiliar words and phrases, and with a full analysis of any special problems of interpretation which arise. Sonnets by other Elizabethan poets are also included, Spenser, Sidney, Drayton and a few other minor authors. The poems of Sir Thomas Wyatt are also given, with both old and modern spelling versions, and with brief notes provided. Check the menu on the left for full details of what is available.'} )
        self.assertResponse(respData)

class TestResetFixture(testLib.RestTestCase):
    """Test whether the resetFixture method works"""
    def assertResponse(self, respData, errCode = testLib.RestTestCase.ERR_BAD_CREDENTIALS):
        expected = { 'errCode' : errCode }
        self.assertDictEqual(expected, respData)

    def testLogin(self):
        respData = self.makeRequest("/users/add", method="POST", data = {'user' : 'user1', 'password' : 'passw'} )
        respData = self.makeRequest("/TESTAPI/resetFixture", method="POST")
        respData = self.makeRequest("/users/login", method="POST", data = {'user' : 'user1', 'password' : 'passw'} )
        self.assertResponse(respData)


