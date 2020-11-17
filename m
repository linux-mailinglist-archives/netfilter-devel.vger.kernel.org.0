Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 410F32B587C
	for <lists+netfilter-devel@lfdr.de>; Tue, 17 Nov 2020 04:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgKQDtP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 16 Nov 2020 22:49:15 -0500
Received: from mail.redfish-solutions.com ([45.33.216.244]:34910 "EHLO
        mail.redfish-solutions.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725730AbgKQDtP (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 16 Nov 2020 22:49:15 -0500
X-Greylist: delayed 732 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Nov 2020 22:49:14 EST
Received: from [192.168.3.4] (174-27-108-50.bois.qwest.net [174.27.108.50] (may be forged))
        (authenticated bits=0)
        by mail.redfish-solutions.com (8.15.2/8.15.2) with ESMTPSA id 0AH3auXP314392
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Nov 2020 20:36:56 -0700
From:   Philip Prindeville <philipp_subx@redfish-solutions.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.20.0.2.21\))
Subject: Issues w/ db-ip country database
Message-Id: <8B419AF6-031F-4F6A-A3FB-3118780F6119@redfish-solutions.com>
Date:   Mon, 16 Nov 2020 20:36:56 -0700
Cc:     jengelh@inai.de
To:     netfilter-devel@vger.kernel.org
X-Mailer: Apple Mail (2.3654.20.0.2.21)
X-Scanned-By: MIMEDefang 2.84 on 192.168.1.3
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

I’ve been having issues with the quality of data coming from Eris Networks in the dbip-country-lite database.

Many known blocks owned by Chinanet for instance, don’t show up as /11 or /13 networks, but as dozens of /23 networks instead in China, the US, Japan, and Canada.  Clearly not correct.

I’m not sure if the authors: have faulty data collection; are being convinced/coerced to ship bad data by certain governments; or their data collection methods have been reverse-engineered and someone is using that information to compromise their data; etc.

Has anyone else had similar experiences?

Should we fall back on the GeoLite2 Country database from MaxMind instead?

Thanks,

-Philip

