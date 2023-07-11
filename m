Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A532174F509
	for <lists+netfilter-devel@lfdr.de>; Tue, 11 Jul 2023 18:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjGKQWa (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 11 Jul 2023 12:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjGKQW3 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 11 Jul 2023 12:22:29 -0400
X-Greylist: delayed 953 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 11 Jul 2023 09:22:27 PDT
Received: from mail.redfish-solutions.com (mail.redfish-solutions.com [24.116.100.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0E2121
        for <netfilter-devel@vger.kernel.org>; Tue, 11 Jul 2023 09:22:27 -0700 (PDT)
Received: from smtpclient.apple (macbook3-7.redfish-solutions.com [192.168.8.12])
        (authenticated bits=0)
        by mail.redfish-solutions.com (8.17.1/8.16.1) with ESMTPSA id 36BG6TW8078965
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 10:06:29 -0600
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: Re: [PATCH 1/1] xt_asn: support quiet mode
From:   Philip Prindeville <philipp@redfish-solutions.com>
In-Reply-To: <695806p-1nos-43ps-7rs8-nrnpor8r6r73@vanv.qr>
Date:   Tue, 11 Jul 2023 10:06:15 -0600
Cc:     netfilter-devel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <29A66843-2208-457A-8DFC-16A5078FF821@redfish-solutions.com>
References: <20230710044718.2682302-1-philipp@redfish-solutions.com>
 <695806p-1nos-43ps-7rs8-nrnpor8r6r73@vanv.qr>
To:     Jan Engelhardt <jengelh@inai.de>
X-Mailer: Apple Mail (2.3731.600.7)
X-Scanned-By: MIMEDefang 3.4.1 on 192.168.8.3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org



> On Jul 11, 2023, at 12:27 AM, Jan Engelhardt <jengelh@inai.de> wrote:
> 
> On Monday 2023-07-10 06:47, Philip Prindeville wrote:
>> Signed-off-by: Philip Prindeville <philipp@redfish-solutions.com>
> 
> Both applied.

Thanks!

