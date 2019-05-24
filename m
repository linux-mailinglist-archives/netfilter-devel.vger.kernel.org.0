Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 813B92A05C
	for <lists+netfilter-devel@lfdr.de>; Fri, 24 May 2019 23:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404219AbfEXV1L (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 24 May 2019 17:27:11 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:59039 "EHLO
        ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404163AbfEXV1L (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 24 May 2019 17:27:11 -0400
Received: from [31.4.219.201] (helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <pablo@gnumonks.org>)
        id 1hUHiW-0000cN-94; Fri, 24 May 2019 23:27:10 +0200
Date:   Fri, 24 May 2019 23:27:07 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     Eric Garver <e@erig.me>, netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH 0/3] Support intra-transaction rule references
Message-ID: <20190524212707.yqfa4o64jyrf5qkl@salvia>
References: <20190522153035.19806-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522153035.19806-1-phil@nwl.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Spam-Score: -2.7 (--)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, May 22, 2019 at 05:30:32PM +0200, Phil Sutter wrote:
[...]
> Phil Sutter (3):
>   src: Fix cache_flush() in cache_needs_more() logic
>   rule: Introduce rule_lookup_by_index()
>   src: Support intra-transaction rule references

nft-tests.py shows errors here, something broken in the last patch it
seems. Please revamp and resubmit. Thanks!
