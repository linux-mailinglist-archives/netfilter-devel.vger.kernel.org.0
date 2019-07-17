Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7367D6B819
	for <lists+netfilter-devel@lfdr.de>; Wed, 17 Jul 2019 10:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbfGQIV4 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 17 Jul 2019 04:21:56 -0400
Received: from mail.us.es ([193.147.175.20]:34500 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbfGQIV4 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 17 Jul 2019 04:21:56 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 976F5BEBAD
        for <netfilter-devel@vger.kernel.org>; Wed, 17 Jul 2019 10:21:52 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 8821AFF6CC
        for <netfilter-devel@vger.kernel.org>; Wed, 17 Jul 2019 10:21:52 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 871E8DA708; Wed, 17 Jul 2019 10:21:52 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 75EB3DA732;
        Wed, 17 Jul 2019 10:21:50 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 17 Jul 2019 10:21:50 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 534134265A2F;
        Wed, 17 Jul 2019 10:21:50 +0200 (CEST)
Date:   Wed, 17 Jul 2019 10:21:49 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Fernando Fernandez Mancera <ffmancera@riseup.net>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft v2] src: introduce SYNPROXY matching
Message-ID: <20190717082149.a2k7pdqvjushamf6@salvia>
References: <20190622171207.818-1-ffmancera@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190622171207.818-1-ffmancera@riseup.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sat, Jun 22, 2019 at 07:12:08PM +0200, Fernando Fernandez Mancera wrote:
> Add support for "synproxy" statement.

Applied, thanks Fernando.

nft-test.py -j

shows this:

ERROR: did not find JSON equivalent for rule 'synproxy mss 1460 wscale 5 timestamp sack-perm'
py/inet/synproxy.t.json.got:
WARNING: line 2: Wrote JSON equivalent for rule synproxy mss 1460 wscale 5 timestamp sack-perm
ERROR: did not find JSON equivalent for rule 'synproxy sack-perm'
py/inet/synproxy.t.json.got: WARNING: line 2: Wrote JSON equivalent for rule synproxy sack-perm

please, follow up to fix this. Thanks.
