Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 419F0918DA
	for <lists+netfilter-devel@lfdr.de>; Sun, 18 Aug 2019 20:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfHRS16 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 18 Aug 2019 14:27:58 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:51854 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726270AbfHRS16 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 18 Aug 2019 14:27:58 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1hzPuH-00052c-0e; Sun, 18 Aug 2019 20:27:57 +0200
Date:   Sun, 18 Aug 2019 20:27:57 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Ander Juaristi <a@juaristi.eus>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft v7 1/2] evaluate: New internal helper
 __expr_evaluate_range
Message-ID: <20190818182757.5fdxjlvachtdhtur@breakpoint.cc>
References: <20190818182013.6765-1-a@juaristi.eus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190818182013.6765-1-a@juaristi.eus>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Ander Juaristi <a@juaristi.eus> wrote:
> Signed-off-by: Ander Juaristi <a@juaristi.eus>

This could use a changelog.

Example:

This is used by the followup patch to evaluate a range without emitting
an error when the left value is larger than the right one.

This is done to handle time-matching such as
23:00-01:00 -- expr_evaluate_range() will reject this, but
we want to be able to evaluate and then handle this as a request
to match from 23:00 to 1am.
