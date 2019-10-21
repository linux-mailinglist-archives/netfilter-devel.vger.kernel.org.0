Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB54DF23E
	for <lists+netfilter-devel@lfdr.de>; Mon, 21 Oct 2019 17:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729838AbfJUP71 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 21 Oct 2019 11:59:27 -0400
Received: from correo.us.es ([193.147.175.20]:45848 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729835AbfJUP7U (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 21 Oct 2019 11:59:20 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 3704215AEB3
        for <netfilter-devel@vger.kernel.org>; Mon, 21 Oct 2019 17:59:17 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 2929FCA0F3
        for <netfilter-devel@vger.kernel.org>; Mon, 21 Oct 2019 17:59:17 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 1E46FCE15C; Mon, 21 Oct 2019 17:59:17 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 5F2AFB8004;
        Mon, 21 Oct 2019 17:59:12 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 21 Oct 2019 17:59:12 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 38FC342EF4E1;
        Mon, 21 Oct 2019 17:59:12 +0200 (CEST)
Date:   Mon, 21 Oct 2019 17:59:14 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org,
        =?iso-8859-1?Q?M=E1t=E9?= Eckl <ecklm94@gmail.com>
Subject: Re: [nft PATCH] tproxy: Add missing error checking when parsing from
 netlink
Message-ID: <20191021155914.p6tpa62pkfftb6o7@salvia>
References: <20191021144003.13415-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021144003.13415-1-phil@nwl.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Oct 21, 2019 at 04:40:03PM +0200, Phil Sutter wrote:
> netlink_get_register() may return NULL and every other caller checks
> that. Assuming this situation is not expected, just jump to 'err' label
> without queueing an explicit error message.
> 
> Fixes: 2be1d52644cf7 ("src: Add tproxy support")
> Signed-off-by: Phil Sutter <phil@nwl.cc>

Acked-by: Pablo Neira Ayuso <pablo@netfilter.org>
