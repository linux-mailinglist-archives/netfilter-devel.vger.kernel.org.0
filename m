Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6C074A63A8
	for <lists+netfilter-devel@lfdr.de>; Tue,  1 Feb 2022 19:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235630AbiBASWL (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 1 Feb 2022 13:22:11 -0500
Received: from mail.redfish-solutions.com ([45.33.216.244]:33800 "EHLO
        mail.redfish-solutions.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230372AbiBASWK (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 1 Feb 2022 13:22:10 -0500
Received: from smtpclient.apple (macbook3.redfish-solutions.com [192.168.3.4])
        (authenticated bits=0)
        by mail.redfish-solutions.com (8.16.1/8.16.1) with ESMTPSA id 211IM1OU282653
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 1 Feb 2022 11:22:01 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [PATCH v2 1/1] xt_ECHO, xt_TARPIT: make properly conditional on
 IPv6
From:   Philip Prindeville <philipp_subx@redfish-solutions.com>
In-Reply-To: <o9236r6-q17s-4p97-r8o0-rnr66543s30@vanv.qr>
Date:   Tue, 1 Feb 2022 11:22:01 -0700
Cc:     Jeremy Sowden <jeremy@azazel.net>, netfilter-devel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <E3987215-778D-416E-B692-4C0C5C6FE536@redfish-solutions.com>
References: <20210926195734.702772-1-philipp@redfish-solutions.com>
 <5s32r847-4op5-70s2-7o9n-4968n7rso321@vanv.qr>
 <05A51779-4B94-49BA-B1B8-6CA5BE695D80@redfish-solutions.com>
 <Yfe48T7Nxpzp20wL@azazel.net>
 <E7F7FB17-246B-4EFF-9449-FE1764F9816E@redfish-solutions.com>
 <Yfgq6qWKgTV9NEkg@azazel.net>
 <6961516B-8252-404F-B302-33E39EEBC9F3@redfish-solutions.com>
 <o9236r6-q17s-4p97-r8o0-rnr66543s30@vanv.qr>
To:     Jan Engelhardt <jengelh@inai.de>
X-Mailer: Apple Mail (2.3693.60.0.1.1)
X-Scanned-By: MIMEDefang 2.85 on 192.168.4.3
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org



> On Feb 1, 2022, at 10:32 AM, Jan Engelhardt <jengelh@inai.de> wrote:
> 
> 
> On Monday 2022-01-31 19:35, Philip Prindeville wrote:
>> 
>> That would do it.
>> When is 3.19 or 4.0 due out?
> 
> No particular plans, therefore I tagged 3.19 for your enjoyment.


Cheers.

Rebuilding the packaging for openwrt now.

