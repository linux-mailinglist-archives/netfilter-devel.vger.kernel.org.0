Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23DC92566FF
	for <lists+netfilter-devel@lfdr.de>; Sat, 29 Aug 2020 13:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgH2LHi (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 29 Aug 2020 07:07:38 -0400
Received: from correo.us.es ([193.147.175.20]:42196 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726876AbgH2LHh (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 29 Aug 2020 07:07:37 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id DBF44D28C2
        for <netfilter-devel@vger.kernel.org>; Sat, 29 Aug 2020 13:07:35 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id CC86EDA730
        for <netfilter-devel@vger.kernel.org>; Sat, 29 Aug 2020 13:07:35 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id C2399DA704; Sat, 29 Aug 2020 13:07:35 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WELCOMELIST,USER_IN_WHITELIST
        autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id B5BFADA73F;
        Sat, 29 Aug 2020 13:07:33 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Sat, 29 Aug 2020 13:07:33 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 999E242EF4E0;
        Sat, 29 Aug 2020 13:07:33 +0200 (CEST)
Date:   Sat, 29 Aug 2020 13:07:33 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Balazs Scheidler <bazsi77@gmail.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next v2] netfilter: nft_socket: add wildcard support
Message-ID: <20200829110733.GA24324@salvia>
References: <20200828154425.21259-1-pablo@netfilter.org>
 <20200829061915.21634-1-bazsi77@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200829061915.21634-1-bazsi77@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sat, Aug 29, 2020 at 08:19:15AM +0200, Balazs Scheidler wrote:
> Add NFT_SOCKET_WILDCARD to match to wildcard socket listener.

Applied, thanks Balazs.

> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> Signed-off-by: Balazs Scheidler <bazsi77@gmail.com>
> ---
> @Pablo: this contains the enum addition as well as the explicit check for IPv6

Thanks, hopefully this is fixing up the kbuild robot report.
