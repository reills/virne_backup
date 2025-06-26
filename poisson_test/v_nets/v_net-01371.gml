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
  id 1371
  arrival_time 29163.380522452855
  lifetime 35.415338541675425
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 16
    gpu 28
    rom 32
  ]
  node [
    id 1
    label "1"
    cpu 41
    gpu 12
    rom 22
  ]
  node [
    id 2
    label "2"
    cpu 48
    gpu 0
    rom 4
  ]
  node [
    id 3
    label "3"
    cpu 11
    gpu 29
    rom 2
  ]
  node [
    id 4
    label "4"
    cpu 44
    gpu 5
    rom 39
  ]
  edge [
    source 0
    target 1
    bw 17
  ]
  edge [
    source 1
    target 2
    bw 15
  ]
  edge [
    source 2
    target 3
    bw 43
  ]
  edge [
    source 3
    target 4
    bw 3
  ]
]
