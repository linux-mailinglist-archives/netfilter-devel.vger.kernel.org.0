Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0162222E1BC
	for <lists+netfilter-devel@lfdr.de>; Sun, 26 Jul 2020 19:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgGZRrD (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 26 Jul 2020 13:47:03 -0400
Received: from mail.redfish-solutions.com ([45.33.216.244]:48906 "EHLO
        mail.redfish-solutions.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726663AbgGZRrD (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 26 Jul 2020 13:47:03 -0400
X-Greylist: delayed 854 seconds by postgrey-1.27 at vger.kernel.org; Sun, 26 Jul 2020 13:47:03 EDT
Received: from macmini.redfish-solutions.com (macmini.redfish-solutions.com [192.168.1.38])
        (authenticated bits=0)
        by mail.redfish-solutions.com (8.15.2/8.15.2) with ESMTPSA id 06QHWjav085249
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Jul 2020 11:32:45 -0600
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH 1/1] geoip: add quiet flag to xt_geoip_build
From:   Philip Prindeville <philipp@redfish-solutions.com>
In-Reply-To: <nycvar.YFH.7.77.849.2005261459250.6469@n3.vanv.qr>
Date:   Sun, 26 Jul 2020 11:32:44 -0600
Cc:     netfilter-devel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <52068C27-7A75-4F28-8DE2-C13CF196E2B5@redfish-solutions.com>
References: <20200525200542.29000-1-philipp@redfish-solutions.com>
 <nycvar.YFH.7.77.849.2005261459250.6469@n3.vanv.qr>
To:     Jan Engelhardt <jengelh@inai.de>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Scanned-By: MIMEDefang 2.84 on 192.168.1.3
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


> On May 26, 2020, at 6:59 AM, Jan Engelhardt <jengelh@inai.de> wrote:
> 
> On Monday 2020-05-25 22:05, Philip Prindeville wrote:
> 
>> From: Philip Prindeville <philipp@redfish-solutions.com>
>> 
>> Conceivably someone might want to run a refresh of the geoip database
>> from within a script, particularly an unattended script such as a cron
>> job.  Don't generate output in that case.
> 
> added.


Thanks.

BTW, when is 3.10 due out?

