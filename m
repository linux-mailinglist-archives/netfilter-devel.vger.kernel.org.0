Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 393F5EE729
	for <lists+netfilter-devel@lfdr.de>; Mon,  4 Nov 2019 19:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbfKDSRL (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 4 Nov 2019 13:17:11 -0500
Received: from correo.us.es ([193.147.175.20]:50158 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728321AbfKDSRK (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 4 Nov 2019 13:17:10 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 29C20C1249
        for <netfilter-devel@vger.kernel.org>; Mon,  4 Nov 2019 19:17:06 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 1A44CA7E1E
        for <netfilter-devel@vger.kernel.org>; Mon,  4 Nov 2019 19:17:06 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 10137A7E16; Mon,  4 Nov 2019 19:17:06 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 38B77A7E1D;
        Mon,  4 Nov 2019 19:17:04 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 04 Nov 2019 19:17:04 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 0A91D41E4803;
        Mon,  4 Nov 2019 19:17:03 +0100 (CET)
Date:   Mon, 4 Nov 2019 19:17:05 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Duncan Roe <duncan_roe@optusnet.com.au>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH libnetfilter_queue] src: doc: Eliminate doxygen warnings
 from ipv{4,6}.c
Message-ID: <20191104181705.sumcn37ldzmbondv@salvia>
References: <20191103112735.30250-1-duncan_roe@optusnet.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191103112735.30250-1-duncan_roe@optusnet.com.au>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Also applied, thanks.
