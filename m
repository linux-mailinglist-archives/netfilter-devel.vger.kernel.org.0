Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE0C45A3E6
	for <lists+netfilter-devel@lfdr.de>; Tue, 23 Nov 2021 14:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbhKWNlI (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 23 Nov 2021 08:41:08 -0500
Received: from mail.netfilter.org ([217.70.188.207]:60536 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235246AbhKWNlH (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 23 Nov 2021 08:41:07 -0500
Received: from netfilter.org (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 09A3F64706;
        Tue, 23 Nov 2021 14:35:49 +0100 (CET)
Date:   Tue, 23 Nov 2021 14:37:55 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Ken-ichirou MATSUZAWA <chamas@h4.dion.ne.jp>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCHv2 ulogd 2/2] NFLOG: attach struct nf_conntrack
Message-ID: <YZzus8xfaNos8MQ5@salvia>
References: <YX1CnY+TPBZuYC8R@azazel.net>
 <20211118110918.18944-1-chamas@h4.dion.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211118110918.18944-1-chamas@h4.dion.ne.jp>
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Nov 18, 2021 at 08:09:19PM +0900, Ken-ichirou MATSUZAWA wrote:
> put nf_conntrack in ct outputkey when "attach_conntrack" is specified.
> But there is no way to show both nflog "raw" and "ct" now.

Applied, thanks.
