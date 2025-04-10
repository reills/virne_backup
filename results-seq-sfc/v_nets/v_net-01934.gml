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
  id 1934
  arrival_time 42622.92598794847
  lifetime 157.49556663470148
  num_nodes 2
  type "path"
  node [
    id 0
    label "0"
    cpu 39
    gpu 13
    rom 40
  ]
  node [
    id 1
    label "1"
    cpu 28
    gpu 37
    rom 7
  ]
  edge [
    source 0
    target 1
    bw 38
  ]
]
