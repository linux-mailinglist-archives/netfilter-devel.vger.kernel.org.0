Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D998169A62
	for <lists+netfilter-devel@lfdr.de>; Sun, 23 Feb 2020 23:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgBWWHK (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 23 Feb 2020 17:07:10 -0500
Received: from correo.us.es ([193.147.175.20]:57594 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbgBWWHJ (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 23 Feb 2020 17:07:09 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 3D600EBAC8
        for <netfilter-devel@vger.kernel.org>; Sun, 23 Feb 2020 23:07:03 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 2FBF5DA788
        for <netfilter-devel@vger.kernel.org>; Sun, 23 Feb 2020 23:07:03 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 2580DDA3C2; Sun, 23 Feb 2020 23:07:03 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 5A246DA7B6;
        Sun, 23 Feb 2020 23:07:01 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Sun, 23 Feb 2020 23:07:01 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 3C6F042EF4E0;
        Sun, 23 Feb 2020 23:07:01 +0100 (CET)
Date:   Sun, 23 Feb 2020 23:07:05 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH 1/3] xtables: Align effect of -4/-6 options with
 legacy
Message-ID: <20200223220705.udnaurzek3xu3ijw@salvia>
References: <20200221140324.21082-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221140324.21082-1-phil@nwl.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Feb 21, 2020 at 03:03:22PM +0100, Phil Sutter wrote:
> Legacy iptables doesn't accept -4 or -6 if they don't match the
> symlink's native family. The only exception to that is iptables-restore
> which simply ignores the lines introduced by non-matching options, which
> is useful to create combined dump files for feeding into both
> iptables-restore and ip6tables-restore.

Series look good to me.
