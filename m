Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDFB282CE7
	for <lists+netfilter-devel@lfdr.de>; Sun,  4 Oct 2020 21:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgJDTLS (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 4 Oct 2020 15:11:18 -0400
Received: from correo.us.es ([193.147.175.20]:55440 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbgJDTLR (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 4 Oct 2020 15:11:17 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id D55D9E8623
        for <netfilter-devel@vger.kernel.org>; Sun,  4 Oct 2020 21:11:16 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id C9236DA73F
        for <netfilter-devel@vger.kernel.org>; Sun,  4 Oct 2020 21:11:16 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id BEB42DA73D; Sun,  4 Oct 2020 21:11:16 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WELCOMELIST,USER_IN_WHITELIST autolearn=disabled
        version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id B4DE5DA72F;
        Sun,  4 Oct 2020 21:11:14 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Sun, 04 Oct 2020 21:11:14 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 9744142EF9E0;
        Sun,  4 Oct 2020 21:11:14 +0200 (CEST)
Date:   Sun, 4 Oct 2020 21:11:14 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [net-next PATCH 2/2] net: netfilter: Implement fast bitwise
 expression
Message-ID: <20201004191114.GB3823@salvia>
References: <20201001165744.25466-1-phil@nwl.cc>
 <20201001165744.25466-3-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201001165744.25466-3-phil@nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Oct 01, 2020 at 06:57:44PM +0200, Phil Sutter wrote:
> A typical use of bitwise expression is to mask out parts of an IP
> address when matching on the network part only. Optimize for this common
> use with a fast variant for NFT_BITWISE_BOOL-type expressions operating
> on 32bit-sized values.

Applied, thanks.
