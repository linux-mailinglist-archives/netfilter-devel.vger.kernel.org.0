Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6185B12D446
	for <lists+netfilter-devel@lfdr.de>; Mon, 30 Dec 2019 21:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbfL3UCw (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 30 Dec 2019 15:02:52 -0500
Received: from correo.us.es ([193.147.175.20]:41446 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727667AbfL3UCw (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 30 Dec 2019 15:02:52 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id B80B911EB29
        for <netfilter-devel@vger.kernel.org>; Mon, 30 Dec 2019 21:02:49 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id A9BEDDA710
        for <netfilter-devel@vger.kernel.org>; Mon, 30 Dec 2019 21:02:49 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 9F327DA705; Mon, 30 Dec 2019 21:02:49 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-106.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        PDS_TONAME_EQ_TOLOCAL_SHORT,SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled
        version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id AC3B5DA705;
        Mon, 30 Dec 2019 21:02:47 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 30 Dec 2019 21:02:47 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [185.124.28.61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 6221142EE38E;
        Mon, 30 Dec 2019 21:02:47 +0100 (CET)
Date:   Mon, 30 Dec 2019 21:02:45 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     wenxu <wenxu@ucloud.cn>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf] netfilter: nft_flow_offload: fix unnecessary use
 counter decrease in destory
Message-ID: <20191230200245.wr3tknzvduzecvaw@salvia>
References: <1576832926-4268-1-git-send-email-wenxu@ucloud.cn>
 <c9e07a82-ea38-d0bc-3ffa-cb0b5bc7ff95@ucloud.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9e07a82-ea38-d0bc-3ffa-cb0b5bc7ff95@ucloud.cn>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Dec 30, 2019 at 09:25:36PM +0800, wenxu wrote:
> Hi pablo,
> 
> How about this patch?

This test still fails after a second run with this patch:

./run-tests.sh testcases/flowtable/0009deleteafterflush_0
I: using nft binary ./../../src/nft

W: [FAILED]     testcases/flowtable/0009deleteafterflush_0: got 1
Error: Could not process rule: Device or resource busy
delete flowtable x f
