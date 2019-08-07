Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD10B84D7A
	for <lists+netfilter-devel@lfdr.de>; Wed,  7 Aug 2019 15:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388228AbfHGNgu (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 7 Aug 2019 09:36:50 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:45842 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388200AbfHGNgu (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 7 Aug 2019 09:36:50 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x77DStMg056232;
        Wed, 7 Aug 2019 13:36:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=zr82f5G/ctxGpTMNcbQJQwkkbh5BFjSQ6Bhg7o7pCOE=;
 b=BQhGNZxato1zh6R1tfZxrpV/y/6dObqponNKF12Q2EUcjIHvwscwBXZv2TeRXBZiHObs
 LX8rScGm4FdSSZYBpumdszgmzSdRGUOWBsgxySRafntoVfrXDyUZXWN1KVIE7ST5wfJT
 yBGS5cxUw2xHEPg0HEiNK1rBKDlk7MxW+RwPrpHA2jftTntDUW+I4GYw+EocOxDmO+im
 P5T+9eDQmnj+X9vpjsefco4ELbOmkz681iV1pah8mVjLVdj9oytQurlzryFhMWXjw96G
 A9bGrMl18sUDQt+cE5FtBwXupqHgfnnO6HKQb4Oi7k2uXYPgaqo0WS6SYu8GURKHE+TB fw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2u51pu4fgy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Aug 2019 13:36:43 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x77DWYNR092145;
        Wed, 7 Aug 2019 13:36:42 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2u763hw3af-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Aug 2019 13:36:42 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x77DadFD016768;
        Wed, 7 Aug 2019 13:36:39 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 07 Aug 2019 06:36:38 -0700
Date:   Wed, 7 Aug 2019 16:36:33 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     pablo@netfilter.org
Cc:     netfilter-devel@vger.kernel.org
Subject: [bug report] netfilter: nf_tables: add hardware offload support
Message-ID: <20190807133633.GA22300@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9341 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908070148
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9341 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908070148
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hello Pablo Neira Ayuso,

The patch c9626a2cbdb2: "netfilter: nf_tables: add hardware offload
support" from Jul 9, 2019, leads to the following static checker
warning:

	net/netfilter/nf_tables_offload.c:196 nft_flow_offload_chain()
	warn: always true condition '(((trans->data)->policy) != -1) => (0-255 != (-1))'

net/netfilter/nf_tables_offload.c
   176  static int nft_flow_offload_chain(struct nft_trans *trans,
   177                                    enum flow_block_command cmd)
   178  {
   179          struct nft_chain *chain = trans->ctx.chain;
   180          struct netlink_ext_ack extack = {};
   181          struct flow_block_offload bo = {};
   182          struct nft_base_chain *basechain;
   183          struct net_device *dev;
   184          int err;
   185  
   186          if (!nft_is_base_chain(chain))
   187                  return -EOPNOTSUPP;
   188  
   189          basechain = nft_base_chain(chain);
   190          dev = basechain->ops.dev;
   191          if (!dev || !dev->netdev_ops->ndo_setup_tc)
   192                  return -EOPNOTSUPP;
   193  
   194          /* Only default policy to accept is supported for now. */
   195          if (cmd == FLOW_BLOCK_BIND &&
   196              nft_trans_chain_policy(trans) != -1 &&
                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
nft_trans_chain_policy() is a u8 so it can't be -1.

   197              nft_trans_chain_policy(trans) != NF_ACCEPT)
   198                  return -EOPNOTSUPP;
   199  
   200          bo.command = cmd;
   201          bo.block = &basechain->flow_block;
   202          bo.binder_type = FLOW_BLOCK_BINDER_TYPE_CLSACT_INGRESS;
   203          bo.extack = &extack;
   204          INIT_LIST_HEAD(&bo.cb_list);

regards,
dan carpenter
