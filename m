Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDF9E3E8CC3
	for <lists+netfilter-devel@lfdr.de>; Wed, 11 Aug 2021 11:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236320AbhHKJCe (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 11 Aug 2021 05:02:34 -0400
Received: from mail.netfilter.org ([217.70.188.207]:44222 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236220AbhHKJCb (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 11 Aug 2021 05:02:31 -0400
Received: from netfilter.org (bl11-146-165.dsl.telepac.pt [85.244.146.165])
        by mail.netfilter.org (Postfix) with ESMTPSA id 0614D60056
        for <netfilter-devel@vger.kernel.org>; Wed, 11 Aug 2021 11:01:24 +0200 (CEST)
Date:   Wed, 11 Aug 2021 11:02:03 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Netfilter Development <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH libnetfilter_queue] include: deprecate
 libnetfilter_queue/linux_nfnetlink_queue.h
Message-ID: <20210811090203.GA23374@salvia>
References: <20210810160813.26984-1-pablo@netfilter.org>
 <YRNsdKcEl0z3a2ox@slk1.local.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YRNsdKcEl0z3a2ox@slk1.local.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Aug 11, 2021 at 04:21:40PM +1000, Duncan Roe wrote:
[...]
> Suggest you leave include/libnetfilter_queue/libnetfilter_queue.h unaltered.
> 
> That way, if a user fails to insert linux/netfilter/nfnetlink_queue.h at all, he
> will get the warning. With the patched libnetfilter_queue.h, he will get
> compilation errors where previously he did not.

OK, done and pushed it out. Thanks.
