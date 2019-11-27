Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA59A10B4DE
	for <lists+netfilter-devel@lfdr.de>; Wed, 27 Nov 2019 18:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfK0Rxz (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 27 Nov 2019 12:53:55 -0500
Received: from correo.us.es ([193.147.175.20]:51584 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727017AbfK0Rxz (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 27 Nov 2019 12:53:55 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 3E0E1191921
        for <netfilter-devel@vger.kernel.org>; Wed, 27 Nov 2019 18:53:51 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 2FE99DA70B
        for <netfilter-devel@vger.kernel.org>; Wed, 27 Nov 2019 18:53:51 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 25B34DA707; Wed, 27 Nov 2019 18:53:51 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id F3277DA709;
        Wed, 27 Nov 2019 18:53:48 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 27 Nov 2019 18:53:48 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id D0F9E42EE38E;
        Wed, 27 Nov 2019 18:53:48 +0100 (CET)
Date:   Wed, 27 Nov 2019 18:53:48 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>
Subject: Re: [nft PATCH] nft.8: Fix nat family spec position
Message-ID: <20191127175348.pzoctwrdmqtzkb72@salvia>
References: <20191127125936.23007-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191127125936.23007-1-phil@nwl.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Nov 27, 2019 at 01:59:36PM +0100, Phil Sutter wrote:
> In inet family nat statements, ip/ip6 keyword must come before 'to'
> keyword, not after.
> 
> Fixes: fbe27464dee45 ("src: add nat support for the inet family")
> Cc: Florian Westphal <fw@strlen.de>
> Signed-off-by: Phil Sutter <phil@nwl.cc>

Acked-by: Pablo Neira Ayuso <pablo@netfilter.org>
