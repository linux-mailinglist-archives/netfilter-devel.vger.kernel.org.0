Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77AE7109C79
	for <lists+netfilter-devel@lfdr.de>; Tue, 26 Nov 2019 11:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbfKZKok (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 26 Nov 2019 05:44:40 -0500
Received: from correo.us.es ([193.147.175.20]:49800 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727603AbfKZKok (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 26 Nov 2019 05:44:40 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 2FEADB6C79
        for <netfilter-devel@vger.kernel.org>; Tue, 26 Nov 2019 11:44:37 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 22840FB362
        for <netfilter-devel@vger.kernel.org>; Tue, 26 Nov 2019 11:44:37 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 21ECCBAACC; Tue, 26 Nov 2019 11:44:37 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 2FC69A7EC2;
        Tue, 26 Nov 2019 11:44:35 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 26 Nov 2019 11:44:35 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (barqueta.lsi.us.es [150.214.188.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 1788E426CCBA;
        Tue, 26 Nov 2019 11:44:35 +0100 (CET)
Date:   Tue, 26 Nov 2019 11:44:36 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Duncan Roe <duncan_roe@optusnet.com.au>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH libnetfilter_queue v2] src: Delete code not needed since
 Linux 3.8 in examples/nf-queue.c
Message-ID: <20191126104436.vyiav67vh63pqnfh@salvia>
References: <20191125211059.b2k7e52cgllyk53x@salvia>
 <20191126102546.6751-1-duncan_roe@optusnet.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191126102546.6751-1-duncan_roe@optusnet.com.au>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Nov 26, 2019 at 09:25:46PM +1100, Duncan Roe wrote:
> The removed code sent configuration commands NFQNL_CFG_CMD_PF_UNBIND &
> NFQNL_CFG_CMD_PF_BIND which the kernel required prior to 3.8.

Applied, thanks.
