Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D26DD447E51
	for <lists+netfilter-devel@lfdr.de>; Mon,  8 Nov 2021 11:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236768AbhKHK6U (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 8 Nov 2021 05:58:20 -0500
Received: from mail.netfilter.org ([217.70.188.207]:46998 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238855AbhKHK6U (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 8 Nov 2021 05:58:20 -0500
Received: from netfilter.org (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 638F66063C;
        Mon,  8 Nov 2021 11:53:36 +0100 (CET)
Date:   Mon, 8 Nov 2021 11:55:30 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Will Mortensen <willmo@gmail.com>
Cc:     netfilter-devel@vger.kernel.org, wenxu <wenxu@ucloud.cn>
Subject: Re: [PATCH] netfilter: flowtable: fix IPv6 tunnel addr match
Message-ID: <YYkCIpa0v/AWyv4t@salvia>
References: <20211107012821.629933-1-willmo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211107012821.629933-1-willmo@gmail.com>
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sat, Nov 06, 2021 at 06:28:21PM -0700, Will Mortensen wrote:
> Previously the IPv6 addresses in the key were clobbered and the mask was
> left unset.
> 
> I haven't tested this; I noticed it while skimming the code to
> understand an unrelated issue.

Applied.
