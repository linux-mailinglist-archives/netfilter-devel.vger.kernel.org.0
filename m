Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD52078C7C
	for <lists+netfilter-devel@lfdr.de>; Mon, 29 Jul 2019 15:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbfG2NPf (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 29 Jul 2019 09:15:35 -0400
Received: from correo.us.es ([193.147.175.20]:40182 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728077AbfG2NPf (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 29 Jul 2019 09:15:35 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 1667C114561
        for <netfilter-devel@vger.kernel.org>; Mon, 29 Jul 2019 15:15:32 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 09910DA732
        for <netfilter-devel@vger.kernel.org>; Mon, 29 Jul 2019 15:15:32 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id DED3C909A8; Mon, 29 Jul 2019 15:15:31 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id E633AD2F98;
        Mon, 29 Jul 2019 15:15:29 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 29 Jul 2019 15:15:29 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [47.60.40.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id A75F44265A31;
        Mon, 29 Jul 2019 15:15:29 +0200 (CEST)
Date:   Mon, 29 Jul 2019 15:15:28 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfilter: add include guard to xt_connlabel.h
Message-ID: <20190729131528.4vl6zpyyoyqd7np6@salvia>
References: <20190728155138.29803-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190728155138.29803-1-yamada.masahiro@socionext.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Jul 29, 2019 at 12:51:38AM +0900, Masahiro Yamada wrote:
> Add a header include guard just in case.

Applied to nf.git, thanks.

BTW, is the _UAPI_ prefix really needed? I can see netfilter headers
under include/uapi/ sometimes are prefixed by UAPI and sometimes not.

Thanks.
