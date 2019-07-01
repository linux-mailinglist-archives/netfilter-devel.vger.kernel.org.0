Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 043A725870
	for <lists+netfilter-devel@lfdr.de>; Tue, 21 May 2019 21:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbfEUTpz (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 21 May 2019 15:45:55 -0400
Received: from mail.us.es ([193.147.175.20]:48918 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727275AbfEUTpz (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 21 May 2019 15:45:55 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 0CFA3F2583
        for <netfilter-devel@vger.kernel.org>; Tue, 21 May 2019 21:45:53 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 003FFDA701
        for <netfilter-devel@vger.kernel.org>; Tue, 21 May 2019 21:45:53 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id EA314DA707; Tue, 21 May 2019 21:45:52 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id F303FDA704;
        Tue, 21 May 2019 21:45:50 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 21 May 2019 21:45:50 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id D04734265A31;
        Tue, 21 May 2019 21:45:50 +0200 (CEST)
Date:   Tue, 21 May 2019 21:45:50 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH] Revert "build: don't include tests in released
 tarball"
Message-ID: <20190521194550.tvb5bkwlay7ur6hi@salvia>
References: <20190520114357.4905-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520114357.4905-1-phil@nwl.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, May 20, 2019 at 01:43:57PM +0200, Phil Sutter wrote:
> This reverts commit 4b187eeed49dc507d38438affabe90d36847412d.
> 
> Having the testsuites available in release tarball is helpful for
> SRPM-based CI at least. The other two suites are included already, so
> it's actually 2:1 keep or drop.

Applied, thanks.
