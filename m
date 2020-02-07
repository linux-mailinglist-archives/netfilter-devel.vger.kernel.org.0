Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BADB515569B
	for <lists+netfilter-devel@lfdr.de>; Fri,  7 Feb 2020 12:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgBGLZL (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 7 Feb 2020 06:25:11 -0500
Received: from correo.us.es ([193.147.175.20]:60684 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726674AbgBGLZL (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 7 Feb 2020 06:25:11 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id BBFB311AD0C
        for <netfilter-devel@vger.kernel.org>; Fri,  7 Feb 2020 12:25:10 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id AB781DA722
        for <netfilter-devel@vger.kernel.org>; Fri,  7 Feb 2020 12:25:10 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id A09F0DA720; Fri,  7 Feb 2020 12:25:10 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id C57ECDA718;
        Fri,  7 Feb 2020 12:25:08 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 07 Feb 2020 12:25:08 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id A511B42EF42B;
        Fri,  7 Feb 2020 12:25:08 +0100 (CET)
Date:   Fri, 7 Feb 2020 12:25:07 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH 0/4] Extend testsuites to run against installed
 binaries
Message-ID: <20200207112507.f5eyhaxfyyftzqm7@salvia>
References: <20200206005851.28962-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200206005851.28962-1-phil@nwl.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Feb 06, 2020 at 01:58:47AM +0100, Phil Sutter wrote:
> Help with CI integration by allowing to run the testsuite on installed
> binaries instead of the local ones in the built source tree.
> 
> This series contains an unrelated Python3 fix for json_echo test tool in
> patch 1, the remaining three extend json_echo, monitor and py testsuites
> as described. Of the remaining testsuites, shell already accepts NFT env
> variable and build is bound to source tree anyway.

LGTM.
