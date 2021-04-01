Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0FB3510BE
	for <lists+netfilter-devel@lfdr.de>; Thu,  1 Apr 2021 10:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbhDAISi (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 1 Apr 2021 04:18:38 -0400
Received: from mail.netfilter.org ([217.70.188.207]:51912 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233491AbhDAISN (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 1 Apr 2021 04:18:13 -0400
Received: from us.es (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id DB68D63E34;
        Thu,  1 Apr 2021 10:17:56 +0200 (CEST)
Date:   Thu, 1 Apr 2021 10:18:08 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     wenxu@ucloud.cn
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next 1/2] netfilter: flowtable: add vlan match offload
 support
Message-ID: <20210401081808.GA7908@salvia>
References: <1617263411-3244-1-git-send-email-wenxu@ucloud.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1617263411-3244-1-git-send-email-wenxu@ucloud.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Apr 01, 2021 at 03:50:10PM +0800, wenxu@ucloud.cn wrote:
> From: wenxu <wenxu@ucloud.cn>
> 
> This patch support vlan_id, vlan_priority and vlan_proto match
> for flowtable offload

No driver in tree is using this code.
