Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79588A20E8
	for <lists+netfilter-devel@lfdr.de>; Thu, 29 Aug 2019 18:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbfH2Qan (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 29 Aug 2019 12:30:43 -0400
Received: from correo.us.es ([193.147.175.20]:44584 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727046AbfH2Qan (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 29 Aug 2019 12:30:43 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id ABB1A20A528
        for <netfilter-devel@vger.kernel.org>; Thu, 29 Aug 2019 18:30:39 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 9E213DA72F
        for <netfilter-devel@vger.kernel.org>; Thu, 29 Aug 2019 18:30:39 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 93C34D2B1F; Thu, 29 Aug 2019 18:30:39 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 60814DA7B6;
        Thu, 29 Aug 2019 18:30:37 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 29 Aug 2019 18:30:37 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 3F7984265A5A;
        Thu, 29 Aug 2019 18:30:37 +0200 (CEST)
Date:   Thu, 29 Aug 2019 18:30:38 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Alin Nastac <alin.nastac@gmail.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH] netfilter: reject: fix ICMP csum verification
Message-ID: <20190829163038.hfjqzj6gmaqgarxf@salvia>
References: <1567090431-4538-1-git-send-email-alin.nastac@technicolor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567090431-4538-1-git-send-email-alin.nastac@technicolor.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Aug 29, 2019 at 04:53:51PM +0200, Alin Nastac wrote:
> From: Alin Nastac <alin.nastac@gmail.com>
> 
> Typically transport protocols such as TCP and UDP use an IP
> pseudo-header for their checksum computation, but ICMP does not
> use it.

Already fixed upstream?

commit 5d1549847c76b1ffcf8e388ef4d0f229bdd1d7e8
Author: He Zhe <zhe.he@windriver.com>
Date:   Mon Jun 24 11:17:38 2019 +0800

    netfilter: Fix remainder of pseudo-header protocol 0
