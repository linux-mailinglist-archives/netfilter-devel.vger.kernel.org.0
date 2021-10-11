Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3A44299E9
	for <lists+netfilter-devel@lfdr.de>; Tue, 12 Oct 2021 01:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235735AbhJKXmj (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 11 Oct 2021 19:42:39 -0400
Received: from mail.netfilter.org ([217.70.188.207]:39364 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhJKXmj (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 11 Oct 2021 19:42:39 -0400
Received: from netfilter.org (unknown [78.30.35.141])
        by mail.netfilter.org (Postfix) with ESMTPSA id 3E88563F09;
        Tue, 12 Oct 2021 01:39:03 +0200 (CEST)
Date:   Tue, 12 Oct 2021 01:40:34 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Ken-ichirou MATSUZAWA <chamas@h4.dion.ne.jp>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH ulogd] XML: support nflog pkt output
Message-ID: <YWTLctYBfLHAIjd5@salvia>
References: <20210917220822.37012-1-chamas@h4.dion.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210917220822.37012-1-chamas@h4.dion.ne.jp>
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sat, Sep 18, 2021 at 07:08:23AM +0900, Ken-ichirou MATSUZAWA wrote:
> plugin input type ULOGD_DTYPE_RAW was missing

Applied, thanks
