Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B75CAF221
	for <lists+netfilter-devel@lfdr.de>; Tue, 10 Sep 2019 22:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbfIJUBY (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 10 Sep 2019 16:01:24 -0400
Received: from correo.us.es ([193.147.175.20]:56190 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725797AbfIJUBX (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 10 Sep 2019 16:01:23 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 43ABC1878A0
        for <netfilter-devel@vger.kernel.org>; Tue, 10 Sep 2019 22:01:20 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 3560CDA72F
        for <netfilter-devel@vger.kernel.org>; Tue, 10 Sep 2019 22:01:20 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 2B0AECF823; Tue, 10 Sep 2019 22:01:20 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 244F4DA72F;
        Tue, 10 Sep 2019 22:01:18 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 10 Sep 2019 22:01:18 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [31.4.177.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id CE8AE4265A5A;
        Tue, 10 Sep 2019 22:01:17 +0200 (CEST)
Date:   Tue, 10 Sep 2019 22:01:16 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Fernando Fernandez Mancera <ffmancera@riseup.net>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft] netlink_delinearize: fix wrong conversion to "list"
 in ct mark
Message-ID: <20190910200116.nyq2k2x2n6vvvl4n@salvia>
References: <20190909195247.14535-1-ffmancera@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909195247.14535-1-ffmancera@riseup.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Sep 09, 2019 at 09:52:47PM +0200, Fernando Fernandez Mancera wrote:
> We only prefer "list" representation in "ct event". For any other type of "ct"
> use the "or" representation so nft prints "ct mark set ct mark | 0x00000001"
> instead of "ct mark set ct mark,0x00000001".

Applied, thanks Fernando.
