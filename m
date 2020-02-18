Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4765016342E
	for <lists+netfilter-devel@lfdr.de>; Tue, 18 Feb 2020 22:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbgBRVJB (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 18 Feb 2020 16:09:01 -0500
Received: from correo.us.es ([193.147.175.20]:38246 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726891AbgBRVHs (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 18 Feb 2020 16:07:48 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 6CCA827F8AE
        for <netfilter-devel@vger.kernel.org>; Tue, 18 Feb 2020 22:07:46 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 5E5ACDA3A1
        for <netfilter-devel@vger.kernel.org>; Tue, 18 Feb 2020 22:07:46 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 53FAADA39F; Tue, 18 Feb 2020 22:07:46 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 8F3E1DA3C2;
        Tue, 18 Feb 2020 22:07:44 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 18 Feb 2020 22:07:44 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 70DAE42EE38E;
        Tue, 18 Feb 2020 22:07:44 +0100 (CET)
Date:   Tue, 18 Feb 2020 22:07:43 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Stefano Brivio <sbrivio@redhat.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next 0/2] Two non-functional fixes for nft_set_pipapo
Message-ID: <20200218210743.2tuya2wnryirf4o7@salvia>
References: <cover.1581699548.git.sbrivio@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1581699548.git.sbrivio@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Feb 14, 2020 at 06:14:12PM +0100, Stefano Brivio wrote:
> Patch 1/2 fixes examples of mapping table values in comments,
> patch 2/2 drops an abuse of unlikely(), both reported by Pablo.
> 
> No functional changes are intended here. I'm not entirely sure
> these should be for nf-next, but I guess so as they don't carry
> any functional fix.

Applied this fixes to nf.git. Thanks.
