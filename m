Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE98A23A308
	for <lists+netfilter-devel@lfdr.de>; Mon,  3 Aug 2020 13:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbgHCLCN (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 3 Aug 2020 07:02:13 -0400
Received: from correo.us.es ([193.147.175.20]:46110 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbgHCLCN (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 3 Aug 2020 07:02:13 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 0F79D9A924
        for <netfilter-devel@vger.kernel.org>; Mon,  3 Aug 2020 13:02:12 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 01CD4DA789
        for <netfilter-devel@vger.kernel.org>; Mon,  3 Aug 2020 13:02:12 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id EB586DA72F; Mon,  3 Aug 2020 13:02:11 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WELCOMELIST,USER_IN_WHITELIST autolearn=disabled
        version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id DDBE3DA78A;
        Mon,  3 Aug 2020 13:02:09 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 03 Aug 2020 13:02:09 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (120.205.137.78.rev.vodafone.pt [78.137.205.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 55FD24265A32;
        Mon,  3 Aug 2020 13:02:09 +0200 (CEST)
Date:   Mon, 3 Aug 2020 13:01:44 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     "Jose M. Guisado Gomez" <guigom@riseup.net>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft] src: fix obj list output when reset command
Message-ID: <20200803110144.GA25566@salvia>
References: <20200801213009.59650-1-guigom@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200801213009.59650-1-guigom@riseup.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sat, Aug 01, 2020 at 11:30:10PM +0200, Jose M. Guisado Gomez wrote:
> This patch enables json output when doing a reset command.

Applied, thanks.
