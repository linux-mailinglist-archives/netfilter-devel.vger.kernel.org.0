Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2F35C335
	for <lists+netfilter-devel@lfdr.de>; Mon,  1 Jul 2019 20:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725853AbfGASsd (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 1 Jul 2019 14:48:33 -0400
Received: from mail.us.es ([193.147.175.20]:60190 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726316AbfGASsd (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 1 Jul 2019 14:48:33 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 99CC36D000
        for <netfilter-devel@vger.kernel.org>; Mon,  1 Jul 2019 20:48:31 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 8ABA3DA704
        for <netfilter-devel@vger.kernel.org>; Mon,  1 Jul 2019 20:48:31 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 80617DA732; Mon,  1 Jul 2019 20:48:31 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 89ECC1021A9;
        Mon,  1 Jul 2019 20:48:29 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 01 Jul 2019 20:48:29 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 5DD4B4265A31;
        Mon,  1 Jul 2019 20:48:29 +0200 (CEST)
Date:   Mon, 1 Jul 2019 20:48:28 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Shekhar Sharma <shekhar250198@gmail.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft v10]tests: py: fix python3
Message-ID: <20190701184828.2gmlsltcpfyqf42x@salvia>
References: <20190628200229.3217-1-shekhar250198@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628200229.3217-1-shekhar250198@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sat, Jun 29, 2019 at 01:32:29AM +0530, Shekhar Sharma wrote:
> This converts the nft-test.py file to run on both py2 and py3.

Patch is applied, thanks Shekhar.

Would you follow up with netns support? Thanks.
