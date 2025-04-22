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
  id 1626
  arrival_time 36340.45374313198
  lifetime 4500.305879534654
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 41
    gpu 34
    rom 50
  ]
  node [
    id 1
    label "1"
    cpu 35
    gpu 40
    rom 46
  ]
  node [
    id 2
    label "2"
    cpu 20
    gpu 38
    rom 50
  ]
  node [
    id 3
    label "3"
    cpu 44
    gpu 26
    rom 4
  ]
  node [
    id 4
    label "4"
    cpu 19
    gpu 7
    rom 12
  ]
  node [
    id 5
    label "5"
    cpu 14
    gpu 22
    rom 17
  ]
  node [
    id 6
    label "6"
    cpu 5
    gpu 40
    rom 4
  ]
  edge [
    source 0
    target 1
    bw 38
  ]
  edge [
    source 1
    target 2
    bw 18
  ]
  edge [
    source 2
    target 3
    bw 11
  ]
  edge [
    source 3
    target 4
    bw 42
  ]
  edge [
    source 4
    target 5
    bw 14
  ]
  edge [
    source 5
    target 6
    bw 5
  ]
]
