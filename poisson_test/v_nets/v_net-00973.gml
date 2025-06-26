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
  id 973
  arrival_time 20733.645079779795
  lifetime 114.04522219362046
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 9
    gpu 28
    rom 20
  ]
  node [
    id 1
    label "1"
    cpu 35
    gpu 21
    rom 39
  ]
  node [
    id 2
    label "2"
    cpu 32
    gpu 23
    rom 37
  ]
  node [
    id 3
    label "3"
    cpu 21
    gpu 41
    rom 40
  ]
  node [
    id 4
    label "4"
    cpu 20
    gpu 34
    rom 26
  ]
  edge [
    source 0
    target 1
    bw 46
  ]
  edge [
    source 1
    target 2
    bw 32
  ]
  edge [
    source 2
    target 3
    bw 40
  ]
  edge [
    source 3
    target 4
    bw 18
  ]
]
