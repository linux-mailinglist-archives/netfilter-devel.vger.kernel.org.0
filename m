Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95284FD19A
	for <lists+netfilter-devel@lfdr.de>; Fri, 15 Nov 2019 00:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfKNXe1 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 14 Nov 2019 18:34:27 -0500
Received: from correo.us.es ([193.147.175.20]:54454 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726767AbfKNXe1 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 14 Nov 2019 18:34:27 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 55960191907
        for <netfilter-devel@vger.kernel.org>; Fri, 15 Nov 2019 00:34:23 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 4766DDA4D0
        for <netfilter-devel@vger.kernel.org>; Fri, 15 Nov 2019 00:34:23 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 3CEF2DA4CA; Fri, 15 Nov 2019 00:34:23 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 45711DA72F;
        Fri, 15 Nov 2019 00:34:21 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 15 Nov 2019 00:34:21 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 202B9426CCBA;
        Fri, 15 Nov 2019 00:34:21 +0100 (CET)
Date:   Fri, 15 Nov 2019 00:34:22 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH] segtree: Fix get element for little endian ranges
Message-ID: <20191114233422.4ikzxddz7t7isq6x@salvia>
References: <20191114142122.13931-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191114142122.13931-1-phil@nwl.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Nov 14, 2019 at 03:21:22PM +0100, Phil Sutter wrote:
> This fixes get element command for interval sets with host byte order
> data type, like e.g. mark. During serializing of the range (or element)
> to query, data was exported in wrong byteorder and consequently not
> found in kernel.
> 
> The mystery part is that code seemed correct: When calling
> constant_expr_alloc() from set_elem_add(), the set key's byteorder was
> passed with correct value of BYTEORDER_HOST_ENDIAN.
> 
> Comparison with delete/add element code paths though turned out that in
> those use-cases, constant_expr_alloc() is called with BYTEORDER_INVALID:
> 
> - seg_tree_init() takes byteorder field value of first element in
>   init->expressions (i.e., the elements requested on command line) and
>   assigns that to tree->byteorder
> - tree->byteorder is passed to constant_expr_alloc() in
>   set_insert_interval()
> - the elements' byteorder happens to be the default value
> 
> This patch may not fix the right side, but at least it aligns get with
> add/delete element codes.
> 
> Fixes: a43cc8d53096d ("src: support for get element command")
> Signed-off-by: Phil Sutter <phil@nwl.cc>

Acked-by: Pablo Neira Ayuso <pablo@netfilter.org>
