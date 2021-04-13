Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C20FF35DD83
	for <lists+netfilter-devel@lfdr.de>; Tue, 13 Apr 2021 13:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236918AbhDMLNa (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 13 Apr 2021 07:13:30 -0400
Received: from mail.netfilter.org ([217.70.188.207]:51734 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbhDMLN2 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 13 Apr 2021 07:13:28 -0400
Received: from us.es (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 5D5C262C1A;
        Tue, 13 Apr 2021 13:12:43 +0200 (CEST)
Date:   Tue, 13 Apr 2021 13:13:06 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     wenxu@ucloud.cn
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next v2 2/2] netfilter: flowtable: add vlan pop action
 offload support
Message-ID: <20210413111306.GB2523@salvia>
References: <1617458383-8620-1-git-send-email-wenxu@ucloud.cn>
 <1617458383-8620-2-git-send-email-wenxu@ucloud.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1617458383-8620-2-git-send-email-wenxu@ucloud.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sat, Apr 03, 2021 at 09:59:43PM +0800, wenxu@ucloud.cn wrote:
> From: wenxu <wenxu@ucloud.cn>
> 
> This patch add vlan pop action offload in the flowtable
> offload.

Also applied.
