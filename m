Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 576B9D0C6A
	for <lists+netfilter-devel@lfdr.de>; Wed,  9 Oct 2019 12:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbfJIKRO (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 9 Oct 2019 06:17:14 -0400
Received: from correo.us.es ([193.147.175.20]:40306 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbfJIKRO (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 9 Oct 2019 06:17:14 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id BE6982A2BAE
        for <netfilter-devel@vger.kernel.org>; Wed,  9 Oct 2019 12:17:09 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id B06ACB7FF9
        for <netfilter-devel@vger.kernel.org>; Wed,  9 Oct 2019 12:17:09 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id A5EFFB8001; Wed,  9 Oct 2019 12:17:09 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id A8C5D3C63E;
        Wed,  9 Oct 2019 12:17:07 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 09 Oct 2019 12:17:07 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 89EB142EE393;
        Wed,  9 Oct 2019 12:17:07 +0200 (CEST)
Date:   Wed, 9 Oct 2019 12:17:09 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Eric Jallot <ejallot@gmail.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft] src: obj: fix memleak in parser_bison.y
Message-ID: <20191009101709.e322s2rdilzizexf@salvia>
References: <20191008134724.17839-1-ejallot@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008134724.17839-1-ejallot@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Oct 08, 2019 at 03:47:24PM +0200, Eric Jallot wrote:
> Each object (secmark, synproxy, quota, limit, counter) is dynamically allocated
> by the parser and not freed at exit.
> However, there is no need to use dynamic allocation here because struct obj
> already provides the required storage. Update the grammar to ensure that
> obj_alloc() is called before config occurs.

Applied.
