Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72601EE71D
	for <lists+netfilter-devel@lfdr.de>; Mon,  4 Nov 2019 19:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbfKDSPT (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 4 Nov 2019 13:15:19 -0500
Received: from correo.us.es ([193.147.175.20]:49646 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728216AbfKDSPT (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 4 Nov 2019 13:15:19 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 0AB50C1246
        for <netfilter-devel@vger.kernel.org>; Mon,  4 Nov 2019 19:15:15 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id EFDE3A7E22
        for <netfilter-devel@vger.kernel.org>; Mon,  4 Nov 2019 19:15:14 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id E5AC9A7E0F; Mon,  4 Nov 2019 19:15:14 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 15FB3A7E11;
        Mon,  4 Nov 2019 19:15:13 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 04 Nov 2019 19:15:13 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id DA7BA41E4802;
        Mon,  4 Nov 2019 19:15:12 +0100 (CET)
Date:   Mon, 4 Nov 2019 19:15:14 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Duncan Roe <duncan_roe@optusnet.com.au>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH libnetfilter_queue] src: doc: Fix spelling of CTA_LABELS
 in examples/nf-queue.c
Message-ID: <20191104181514.htlwpa7gk5glr2ex@salvia>
References: <20191103001027.31233-1-duncan_roe@optusnet.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191103001027.31233-1-duncan_roe@optusnet.com.au>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Applied, thanks.
