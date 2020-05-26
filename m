Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA6D81C2026
	for <lists+netfilter-devel@lfdr.de>; Fri,  1 May 2020 23:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbgEAV4j (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 1 May 2020 17:56:39 -0400
Received: from correo.us.es ([193.147.175.20]:48312 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbgEAV4i (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 1 May 2020 17:56:38 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id CC8011C4383
        for <netfilter-devel@vger.kernel.org>; Fri,  1 May 2020 23:56:37 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id C040EBAAA1
        for <netfilter-devel@vger.kernel.org>; Fri,  1 May 2020 23:56:37 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id B57F56D28C; Fri,  1 May 2020 23:56:37 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id DC1CDDA788;
        Fri,  1 May 2020 23:56:35 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 01 May 2020 23:56:35 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id B3B8C4301DE1;
        Fri,  1 May 2020 23:56:35 +0200 (CEST)
Date:   Fri, 1 May 2020 23:56:35 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Michael Braun <michael-dev@fami-braun.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH] tests: dump generated use new nft tool
Message-ID: <20200501215635.GA563@salvia>
References: <20200501210949.2712-1-michael-dev@fami-braun.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501210949.2712-1-michael-dev@fami-braun.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, May 01, 2020 at 11:09:49PM +0200, Michael Braun wrote:
> Instead of using an (possibly outdated) system nft to generate dumps,
> use the newly build tool.
> 
> This fixes the dump output being corrupted if the system tool does
> not support parsing new features.

Applied, thanks.
