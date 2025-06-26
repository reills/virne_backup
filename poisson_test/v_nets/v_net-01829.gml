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
  id 1829
  arrival_time 40462.99204791882
  lifetime 877.9828002232776
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 15
    gpu 1
    rom 46
  ]
  node [
    id 1
    label "1"
    cpu 19
    gpu 31
    rom 32
  ]
  node [
    id 2
    label "2"
    cpu 23
    gpu 46
    rom 50
  ]
  node [
    id 3
    label "3"
    cpu 35
    gpu 33
    rom 25
  ]
  node [
    id 4
    label "4"
    cpu 35
    gpu 24
    rom 43
  ]
  node [
    id 5
    label "5"
    cpu 16
    gpu 50
    rom 49
  ]
  edge [
    source 0
    target 1
    bw 31
  ]
  edge [
    source 1
    target 2
    bw 50
  ]
  edge [
    source 2
    target 3
    bw 36
  ]
  edge [
    source 3
    target 4
    bw 41
  ]
  edge [
    source 4
    target 5
    bw 22
  ]
]
