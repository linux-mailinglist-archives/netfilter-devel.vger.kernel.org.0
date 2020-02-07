Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CEFA155A22
	for <lists+netfilter-devel@lfdr.de>; Fri,  7 Feb 2020 15:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgBGOzH (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 7 Feb 2020 09:55:07 -0500
Received: from correo.us.es ([193.147.175.20]:51024 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726674AbgBGOzG (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 7 Feb 2020 09:55:06 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id B57CBC1272
        for <netfilter-devel@vger.kernel.org>; Fri,  7 Feb 2020 15:55:05 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id A842CDA713
        for <netfilter-devel@vger.kernel.org>; Fri,  7 Feb 2020 15:55:05 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 9D3E5DA70E; Fri,  7 Feb 2020 15:55:05 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id B7231DA709;
        Fri,  7 Feb 2020 15:55:03 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 07 Feb 2020 15:55:03 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [84.78.24.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 6906C42EFB80;
        Fri,  7 Feb 2020 15:55:03 +0100 (CET)
Date:   Fri, 7 Feb 2020 15:54:59 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     netdev@vger.kernel.org, fw@strlen.de,
        netfilter-devel@vger.kernel.org,
        syzbot+adf6c6c2be1c3a718121@syzkaller.appspotmail.com,
        Jozsef Kadlecsik <kadlec@netfilter.org>
Subject: Re: [Patch nf v2 2/3] xt_hashlimit: reduce hashlimit_mutex scope for
 htable_put()
Message-ID: <20200207145459.cb2cxzzvz6wx6nae@salvia>
References: <20200203043053.19192-1-xiyou.wangcong@gmail.com>
 <20200203043053.19192-3-xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200203043053.19192-3-xiyou.wangcong@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sun, Feb 02, 2020 at 08:30:52PM -0800, Cong Wang wrote:
> It is unnecessary to hold hashlimit_mutex for htable_destroy()
> as it is already removed from the global hashtable and its
> refcount is already zero.
> 
> Also, switch hinfo->use to refcount_t so that we don't have
> to hold the mutex until it reaches zero in htable_put().

Applied, thanks.
