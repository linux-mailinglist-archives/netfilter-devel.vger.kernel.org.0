Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A822EB140
	for <lists+netfilter-devel@lfdr.de>; Thu, 31 Oct 2019 14:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfJaNco (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 31 Oct 2019 09:32:44 -0400
Received: from correo.us.es ([193.147.175.20]:59282 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726728AbfJaNco (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 31 Oct 2019 09:32:44 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id D1AA4B6B8F
        for <netfilter-devel@vger.kernel.org>; Thu, 31 Oct 2019 14:32:39 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id C2FB8DA72F
        for <netfilter-devel@vger.kernel.org>; Thu, 31 Oct 2019 14:32:39 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id B89D0B7FF2; Thu, 31 Oct 2019 14:32:39 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id D9D5980132;
        Thu, 31 Oct 2019 14:32:37 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 31 Oct 2019 14:32:37 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id B75BC42EE393;
        Thu, 31 Oct 2019 14:32:37 +0100 (CET)
Date:   Thu, 31 Oct 2019 14:32:39 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Marvin Schmidt <marvin_schmidt@gmx.net>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [libnftnl PATCH 1/1] flowtable: Fix symbol export for clang
Message-ID: <20191031133239.4qd57erktakizd53@salvia>
References: <20191031083706.6867-1-marvin_schmidt@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031083706.6867-1-marvin_schmidt@gmx.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Oct 31, 2019 at 09:37:07AM +0100, Marvin Schmidt wrote:
> clang does not allow attribute declarations after definitions:
> 
>   flowtable.c:41:1: warning: attribute declaration must precede definition [-Wignored-attributes]
>   EXPORT_SYMBOL(nftnl_flowtable_alloc);
>   ^
>   ../include/utils.h:13:41: note: expanded from macro 'EXPORT_SYMBOL'
>   #       define EXPORT_SYMBOL(x) typeof(x) (x) __visible;
>                                                 ^
>   ../include/utils.h:12:35: note: expanded from macro '__visible'
>   #       define __visible        __attribute__((visibility("default")))
>                                                  ^
>   flowtable.c:37:25: note: previous definition is here
>   struct nftnl_flowtable *nftnl_flowtable_alloc(void)
> 
> Move attribute declarations before the symbol definitions just like
> it's done in other source files

Applied, thanks.
