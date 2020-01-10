Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 016E4136BDF
	for <lists+netfilter-devel@lfdr.de>; Fri, 10 Jan 2020 12:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbgAJLUy (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 10 Jan 2020 06:20:54 -0500
Received: from correo.us.es ([193.147.175.20]:56172 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727685AbgAJLUy (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 10 Jan 2020 06:20:54 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id BFEFC20A52C
        for <netfilter-devel@vger.kernel.org>; Fri, 10 Jan 2020 12:20:52 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id B24F6DA70F
        for <netfilter-devel@vger.kernel.org>; Fri, 10 Jan 2020 12:20:52 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id A7C71DA709; Fri, 10 Jan 2020 12:20:52 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id A9EC3DA715;
        Fri, 10 Jan 2020 12:20:50 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 10 Jan 2020 12:20:50 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 8B94442EF4E1;
        Fri, 10 Jan 2020 12:20:50 +0100 (CET)
Date:   Fri, 10 Jan 2020 12:20:50 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH 1/3] monitor: Do not decompose non-anonymous sets
Message-ID: <20200110112050.eso7pcn2gtbuzybb@salvia>
References: <20200110111114.23952-1-phil@nwl.cc>
 <20200110111114.23952-2-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110111114.23952-2-phil@nwl.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Jan 10, 2020 at 12:11:12PM +0100, Phil Sutter wrote:
> They have been decomposed already, trying to do that again causes a
> segfault. This is a similar fix as in commit 8ecb885589591 ("src:
> restore --echo with anonymous sets").
> 
> Signed-off-by: Phil Sutter <phil@nwl.cc>

Acked-by: Pablo Neira Ayuso <pablo@netfilter.org>
