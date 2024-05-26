/*
 * JBoss, Home of Professional Open Source
 * Copyright 2015, Red Hat, Inc. and/or its affiliates, and individual
 * contributors by the @authors tag. See the copyright.txt in the
 * distribution for a full listing of individual contributors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * http://www.apache.org/licenses/LICENSE-2.0
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.jboss.as.quickstarts.kitchensink.rest;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

import jakarta.enterprise.context.RequestScoped;
import jakarta.inject.Inject;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;
import org.jboss.as.quickstarts.kitchensink.service.MemberRegistration;

/**
 * JAX-RS Example
 * <p/>
 * This class produces a RESTful service to read/write the contents of the members table.
 */
@Path("/info")
@RequestScoped
public class InfoResourceRESTService {
    @Inject
    private Logger log;

    @Inject
    MemberRegistration registration;
    
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public List<String> info() {
        // Get the start time of the request
        long startTime = System.currentTimeMillis();

        List<String> info = new ArrayList<String>();

        // If system property 'log.ip' is set to true, log the IP address of the client
        if (System.getProperty("log.ip") != null && System.getProperty("log.ip").equals("true")) {
            String ipAddress = null;
            try {
                ipAddress = InetAddress.getLocalHost().getHostAddress();
            } catch (UnknownHostException e) {
                log.severe("UnknownHostException: " + e.getMessage());
            }
            log.info("info() from " + ipAddress);
        }
        
        // Get the value of system property 'main.host.weiyu' and add it to the list
        info.add("main.host.weiyu: " + System.getProperty("main.host.weiyu"));
        info.add("main.host.hal: " + System.getProperty("main.host.hal"));

        // Get the end time of the request
        long endTime = System.currentTimeMillis();
        // Log the duration of the request
        log.fine("info() took " + (endTime - startTime) + " milliseconds");

        return info;
    }

}
