Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 118A616C026
	for <lists+netfilter-devel@lfdr.de>; Tue, 25 Feb 2020 13:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728976AbgBYMB1 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 25 Feb 2020 07:01:27 -0500
Received: from correo.us.es ([193.147.175.20]:47974 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728965AbgBYMB1 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 25 Feb 2020 07:01:27 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 0C4831878A4
        for <netfilter-devel@vger.kernel.org>; Tue, 25 Feb 2020 13:01:19 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id E921DFC5E9
        for <netfilter-devel@vger.kernel.org>; Tue, 25 Feb 2020 13:01:18 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id E856EFC5E8; Tue, 25 Feb 2020 13:01:18 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 0B80CE1539;
        Tue, 25 Feb 2020 13:01:17 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 25 Feb 2020 13:01:17 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id E231442EE393;
        Tue, 25 Feb 2020 13:01:16 +0100 (CET)
Date:   Tue, 25 Feb 2020 13:01:23 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Stefano Brivio <sbrivio@redhat.com>
Cc:     netfilter-devel@vger.kernel.org, Chen Yi <yiche@redhat.com>
Subject: Re: [PATCH nf] selftests: nft_concat_range: Move option for 'list
 ruleset' before command
Message-ID: <20200225120123.sbwtmq5gd6wnqi6j@salvia>
References: <4029c54d1524098df2cadcc3bae2c93de88f8fcd.1582251063.git.sbrivio@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4029c54d1524098df2cadcc3bae2c93de88f8fcd.1582251063.git.sbrivio@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Feb 21, 2020 at 03:11:56AM +0100, Stefano Brivio wrote:
> Before nftables commit fb9cea50e8b3 ("main: enforce options before
> commands"), 'nft list ruleset -a' happened to work, but it's wrong
> and won't work anymore. Replace it by 'nft -a list ruleset'.

Applied, thanks.
