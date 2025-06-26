graph [
  node_attrs_setting [
    name "cpu"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  node_attrs_setting [
    name "gpu"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  node_attrs_setting [
    name "rom"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  link_attrs_setting "_networkx_list_start"
  link_attrs_setting [
    name "bw"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "link"
    type "resource"
  ]
  id 1020
  arrival_time 21679.88274495901
  lifetime 853.4603668286096
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 29
    gpu 11
    rom 33
  ]
  node [
    id 1
    label "1"
    cpu 41
    gpu 14
    rom 21
  ]
  node [
    id 2
    label "2"
    cpu 19
    gpu 44
    rom 8
  ]
  node [
    id 3
    label "3"
    cpu 7
    gpu 31
    rom 16
  ]
  edge [
    source 0
    target 1
    bw 6
  ]
  edge [
    source 1
    target 2
    bw 47
  ]
  edge [
    source 2
    target 3
    bw 29
  ]
]
